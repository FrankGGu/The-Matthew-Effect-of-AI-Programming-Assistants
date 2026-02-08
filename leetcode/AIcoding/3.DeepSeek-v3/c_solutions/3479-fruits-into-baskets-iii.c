typedef struct {
    int capacity;
    int* fruits;
    int size;
} Basket;

typedef struct {
    Basket* baskets;
    int basketCount;
} FruitCollection;

FruitCollection* createFruitCollection(int basketCount, int capacity) {
    FruitCollection* fc = (FruitCollection*)malloc(sizeof(FruitCollection));
    fc->basketCount = basketCount;
    fc->baskets = (Basket*)malloc(basketCount * sizeof(Basket));
    for (int i = 0; i < basketCount; i++) {
        fc->baskets[i].capacity = capacity;
        fc->baskets[i].fruits = (int*)malloc(capacity * sizeof(int));
        fc->baskets[i].size = 0;
    }
    return fc;
}

void destroyFruitCollection(FruitCollection* fc) {
    for (int i = 0; i < fc->basketCount; i++) {
        free(fc->baskets[i].fruits);
    }
    free(fc->baskets);
    free(fc);
}

int canAddFruit(FruitCollection* fc, int fruitType) {
    for (int i = 0; i < fc->basketCount; i++) {
        Basket* basket = &fc->baskets[i];
        if (basket->size == 0) return 1;
        if (basket->size < basket->capacity && basket->fruits[0] == fruitType) return 1;
    }
    return 0;
}

void addFruit(FruitCollection* fc, int fruitType) {
    for (int i = 0; i < fc->basketCount; i++) {
        Basket* basket = &fc->baskets[i];
        if (basket->size == 0) {
            basket->fruits[basket->size++] = fruitType;
            return;
        }
        if (basket->size < basket->capacity && basket->fruits[0] == fruitType) {
            basket->fruits[basket->size++] = fruitType;
            return;
        }
    }
}

int totalFruits(FruitCollection* fc) {
    int total = 0;
    for (int i = 0; i < fc->basketCount; i++) {
        total += fc->baskets[i].size;
    }
    return total;
}

int numFruitTypes(int* fruits, int fruitsSize) {
    int types[100001] = {0};
    int count = 0;
    for (int i = 0; i < fruitsSize; i++) {
        if (types[fruits[i]] == 0) {
            types[fruits[i]] = 1;
            count++;
        }
    }
    return count;
}

int maxFruitsInBaskets(int* fruits, int fruitsSize, int baskets, int capacity) {
    if (baskets == 0 || capacity == 0 || fruitsSize == 0) return 0;

    int maxTypes = numFruitTypes(fruits, fruitsSize);
    if (baskets >= maxTypes) {
        return fmin(fruitsSize, baskets * capacity);
    }

    int left = 0, right = 0;
    int maxFruits = 0;
    int typeCount = 0;
    int freq[100001] = {0};

    while (right < fruitsSize) {
        if (freq[fruits[right]] == 0) {
            typeCount++;
        }
        freq[fruits[right]]++;

        while (typeCount > baskets) {
            freq[fruits[left]]--;
            if (freq[fruits[left]] == 0) {
                typeCount--;
            }
            left++;
        }

        int currentFruits = 0;
        for (int i = left; i <= right; i++) {
            currentFruits += fmin(freq[fruits[i]], capacity);
        }

        maxFruits = fmax(maxFruits, currentFruits);
        right++;
    }

    return fmin(maxFruits, baskets * capacity);
}

int totalFruit(int* fruits, int fruitsSize, int baskets, int capacity) {
    return maxFruitsInBaskets(fruits, fruitsSize, baskets, capacity);
}