typedef unsigned long long ull;

int longestCommonSubpath(int n, int** paths, int pathsSize, int* pathsColSize) {
    int minLen = pathsColSize[0];
    for (int i = 1; i < pathsSize; i++) {
        if (pathsColSize[i] < minLen) {
            minLen = pathsColSize[i];
        }
    }

    int left = 1, right = minLen;
    int ans = 0;

    ull base = 100001;
    ull mod = 100000000019ULL;

    while (left <= right) {
        int mid = left + (right - left) / 2;

        ull power = 1;
        for (int i = 0; i < mid - 1; i++) {
            power = (power * base) % mod;
        }

        int found = 0;
        ull hash = 0;

        for (int i = 0; i < pathsColSize[0] - mid + 1; i++) {
            if (i == 0) {
                hash = 0;
                for (int j = 0; j < mid; j++) {
                    hash = (hash * base + paths[0][j]) % mod;
                }
            } else {
                hash = (hash - paths[0][i-1] * power % mod + mod) % mod;
                hash = (hash * base + paths[0][i+mid-1]) % mod;
            }
        }

        ull* hashes = malloc(sizeof(ull) * (pathsColSize[0] - mid + 1));
        int hashesSize = 0;
        hashes[hashesSize++] = hash;

        for (int i = 1; i < pathsSize && !found; i++) {
            hash = 0;
            for (int j = 0; j < mid; j++) {
                hash = (hash * base + paths[i][j]) % mod;
            }

            int foundInCurrent = 0;
            for (int k = 0; k < hashesSize; k++) {
                if (hashes[k] == hash) {
                    foundInCurrent = 1;
                    break;
                }
            }

            for (int j = 1; j < pathsColSize[i] - mid + 1 && !foundInCurrent; j++) {
                hash = (hash - paths[i][j-1] * power % mod + mod) % mod;
                hash = (hash * base + paths[i][j+mid-1]) % mod;

                for (int k = 0; k < hashesSize; k++) {
                    if (hashes[k] == hash) {
                        foundInCurrent = 1;
                        break;
                    }
                }
            }

            if (!foundInCurrent) {
                found = 1;
                break;
            }
        }

        free(hashes);

        if (!found) {
            ans = mid;
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    return ans;
}