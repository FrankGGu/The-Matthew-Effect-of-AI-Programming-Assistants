int sumDistance(int* nums, int numsSize, char* s, int d) {
    long long positions[numsSize];
    for (int i = 0; i < numsSize; i++) {
        if (s[i] == 'L') {
            positions[i] = (long long)nums[i] - d;
        } else {
            positions[i] = (long long)nums[i] + d;
        }
    }

    qsort(positions, numsSize, sizeof(long long), 
          (int(*)(const void*, const void*))((long long(*)(long long*, long long*))(
          [](long long* a, long long* b) { 
              return (*a > *b) - (*a < *b); 
          })));

    long long result = 0;
    long long prefix = 0;
    long long mod = 1000000007;

    for (long long i = 0; i < numsSize; i++) {
        result = (result + i * positions[i] - prefix) % mod;
        prefix = (prefix + positions[i]) % mod;
    }

    return result;
}