typedef long long ll;

typedef struct {
    int val;
    int idx;
} Element;

typedef struct {
    int prime;
    int count;
} PrimeFactor;

int cmp(const void* a, const void* b) {
    return *(int*)a - *(int*)b;
}

int cmpElement(const void* a, const void* b) {
    Element* ea = (Element*)a;
    Element* eb = (Element*)b;
    if (ea->val == eb->val) return ea->idx - eb->idx;
    return ea->val - eb->val;
}

int power(int base, int exp, int mod) {
    ll result = 1;
    ll b = base % mod;
    while (exp > 0) {
        if (exp & 1) result = (result * b) % mod;
        b = (b * b) % mod;
        exp >>= 1;
    }
    return result;
}

int primeScore(int num) {
    int score = 0;
    int temp = num;
    for (int i = 2; i * i <= temp; i++) {
        if (temp % i == 0) {
            score++;
            while (temp % i == 0) temp /= i;
        }
    }
    if (temp > 1) score++;
    return score;
}

int maximumScore(int* nums, int numsSize, int k) {
    int MOD = 1000000007;
    int n = numsSize;

    int* nextGreater = (int*)malloc(n * sizeof(int));
    int* prevGreater = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        nextGreater[i] = n;
        prevGreater[i] = -1;
    }

    int stack[n];
    int top = -1;

    for (int i = 0; i < n; i++) {
        while (top >= 0 && primeScore(nums[i]) > primeScore(nums[stack[top]])) {
            nextGreater[stack[top]] = i;
            top--;
        }
        stack[++top] = i;
    }

    top = -1;
    for (int i = n - 1; i >= 0; i--) {
        while (top >= 0 && primeScore(nums[i]) >= primeScore(nums[stack[top]])) {
            prevGreater[stack[top]] = i;
            top--;
        }
        stack[++top] = i;
    }

    Element* elements = (Element*)malloc(n * sizeof(Element));
    for (int i = 0; i < n; i++) {
        elements[i].val = nums[i];
        elements[i].idx = i;
    }

    qsort(elements, n, sizeof(Element), cmpElement);

    ll result = 1;
    int remaining = k;

    for (int i = n - 1; i >= 0 && remaining > 0; i--) {
        int idx = elements[i].idx;
        ll val = elements[i].val;

        ll left = idx - prevGreater[idx];
        ll right = nextGreater[idx] - idx;
        ll total = left * right;

        ll use = total < remaining ? total : remaining;
        result = (result * power(val, use, MOD)) % MOD;
        remaining -= use;
    }

    free(nextGreater);
    free(prevGreater);
    free(elements);

    return result;
}