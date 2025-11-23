#include <stdio.h>
#include <stdlib.h>
#include <math.h>

typedef struct {
    int* parent;
    int* rank;
} UnionFind;

UnionFind* createUnionFind(int n) {
    UnionFind* uf = (UnionFind*)malloc(sizeof(UnionFind));
    uf->parent = (int*)malloc(n * sizeof(int));
    uf->rank = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        uf->parent[i] = i;
        uf->rank[i] = 1;
    }
    return uf;
}

int find(UnionFind* uf, int x) {
    if (uf->parent[x] != x) {
        uf->parent[x] = find(uf, uf->parent[x]);
    }
    return uf->parent[x];
}

void unionSet(UnionFind* uf, int x, int y) {
    int rootX = find(uf, x);
    int rootY = find(uf, y);
    if (rootX != rootY) {
        if (uf->rank[rootX] > uf->rank[rootY]) {
            uf->parent[rootY] = rootX;
        } else {
            uf->parent[rootX] = rootY;
            if (uf->rank[rootX] == uf->rank[rootY]) {
                uf->rank[rootY]++;
            }
        }
    }
}

int isPrime(int n) {
    if (n < 2) return 0;
    for (int i = 2; i * i <= n; i++) {
        if (n % i == 0) return 0;
    }
    return 1;
}

int getGCD(int a, int b) {
    while (b) {
        int temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}

int* getPrimeFactors(int n, int* size) {
    int* factors = NULL;
    *size = 0;
    for (int i = 2; i * i <= n; i++) {
        if (n % i == 0) {
            int count = 0;
            while (n % i == 0) {
                n /= i;
                count++;
            }
            factors = (int*)realloc(factors, (*size + 1) * sizeof(int));
            factors[*size] = i;
            (*size)++;
        }
    }
    if (n > 1) {
        factors = (int*)realloc(factors, (*size + 1) * sizeof(int));
        factors[*size] = n;
        (*size)++;
    }
    return factors;
}

bool canTraverseAllNodes(int* nums, int numsSize) {
    if (numsSize == 1) return true;
    int maxNum = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > maxNum) maxNum = nums[i];
    }
    UnionFind* uf = createUnionFind(maxNum + 1);
    for (int i = 0; i < numsSize; i++) {
        int n = nums[i];
        int* factors = NULL;
        int factorCount = 0;
        factors = getPrimeFactors(n, &factorCount);
        for (int j = 0; j < factorCount; j++) {
            unionSet(uf, factors[0], factors[j]);
        }
        free(factors);
    }
    int root = find(uf, nums[0]);
    for (int i = 1; i < numsSize; i++) {
        if (find(uf, nums[i]) != root) {
            free(uf->parent);
            free(uf->rank);
            free(uf);
            return false;
        }
    }
    free(uf->parent);
    free(uf->rank);
    free(uf);
    return true;
}

bool canTraverseAllPairs(int* nums, int numsSize) {
    if (numsSize == 1) return true;
    int maxNum = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > maxNum) maxNum = nums[i];
    }
    UnionFind* uf = createUnionFind(maxNum + 1);
    for (int i = 0; i < numsSize; i++) {
        int n = nums[i];
        int* factors = NULL;
        int factorCount = 0;
        factors = getPrimeFactors(n, &factorCount);
        for (int j = 0; j < factorCount; j++) {
            unionSet(uf, factors[0], factors[j]);
        }
        free(factors);
    }
    int root = find(uf, nums[0]);
    for (int i = 1; i < numsSize; i++) {
        if (find(uf, nums[i]) != root) {
            free(uf->parent);
            free(uf->rank);
            free(uf);
            return false;
        }
    }
    free(uf->parent);
    free(uf->rank);
    free(uf);
    return true;
}

bool canTraverseAllNodesWithGCD(int* nums, int numsSize) {
    if (numsSize == 1) return true;
    int maxNum = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > maxNum) maxNum = nums[i];
    }
    UnionFind* uf = createUnionFind(maxNum + 1);
    for (int i = 0; i < numsSize; i++) {
        for (int j = i + 1; j < numsSize; j++) {
            int g = getGCD(nums[i], nums[j]);
            if (g > 1) {
                unionSet(uf, nums[i], nums[j]);
            }
        }
    }
    int root = find(uf, nums[0]);
    for (int i = 1; i < numsSize; i++) {
        if (find(uf, nums[i]) != root) {
            free(uf->parent);
            free(uf->rank);
            free(uf);
            return false;
        }
    }
    free(uf->parent);
    free(uf->rank);
    free(uf);
    return true;
}

bool canTraverseAllNodesWithGCDAndPrimes(int* nums, int numsSize) {
    if (numsSize == 1) return true;
    int maxNum = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > maxNum) maxNum = nums[i];
    }
    UnionFind* uf = createUnionFind(maxNum + 1);
    for (int i = 0; i < numsSize; i++) {
        int n = nums[i];
        int* factors = NULL;
        int factorCount = 0;
        factors = getPrimeFactors(n, &factorCount);
        for (int j = 0; j < factorCount; j++) {
            unionSet(uf, factors[0], factors[j]);
        }
        free(factors);
    }
    int root = find(uf, nums[0]);
    for (int i = 1; i < numsSize; i++) {
        if (find(uf, nums[i]) != root) {
            free(uf->parent);
            free(uf->rank);
            free(uf);
            return false;
        }
    }
    free(uf->parent);
    free(uf->rank);
    free(uf);
    return true;
}

bool canTraverseAllNodesWithGCDAndPrimesAndUnion(int* nums, int numsSize) {
    if (numsSize == 1) return true;
    int maxNum = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > maxNum) maxNum = nums[i];
    }
    UnionFind* uf = createUnionFind(maxNum + 1);
    for (int i = 0; i < numsSize; i++) {
        int n = nums[i];
        int* factors = NULL;
        int factorCount = 0;
        factors = getPrimeFactors(n, &factorCount);
        for (int j = 0; j < factorCount; j++) {
            unionSet(uf, factors[0], factors[j]);
        }
        free(factors);
    }
    int root = find(uf, nums[0]);
    for (int i = 1; i < numsSize; i++) {
        if (find(uf, nums[i]) != root) {
            free(uf->parent);
            free(uf->rank);
            free(uf);
            return false;
        }
    }
    free(uf->parent);
    free(uf->rank);
    free(uf);
    return true;
}

bool canTraverseAllNodesWithGCDAndPrimesAndUnionAndCheck(int* nums, int numsSize) {
    if (numsSize == 1) return true;
    int maxNum = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > maxNum) maxNum = nums[i];
    }
    UnionFind