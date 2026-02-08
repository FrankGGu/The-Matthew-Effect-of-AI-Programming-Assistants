#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int *avoidFlood(int *rains, int rainsSize, int *returnSize) {
    int *ans = (int *)malloc(sizeof(int) * rainsSize);
    *returnSize = rainsSize;

    int *last_rain = (int *)malloc(sizeof(int) * 200001);
    for (int i = 0; i <= 200000; i++) {
        last_rain[i] = -1;
    }

    int *dry_days = (int *)malloc(sizeof(int) * rainsSize);
    int dry_count = 0;

    for (int i = 0; i < rainsSize; i++) {
        if (rains[i] > 0) {
            if (last_rain[rains[i]] != -1) {
                *returnSize = 0;
                return NULL;
            }
            ans[i] = -1;
            last_rain[rains[i]] = i;
        } else {
            ans[i] = 1;
            dry_days[dry_count++] = i;
        }
    }

    int *tree = (int *)malloc(sizeof(int) * (4 * rainsSize));
    int *dry_days_sorted = (int *)malloc(sizeof(int) * dry_count);
    for (int i = 0; i < dry_count; i++) {
        dry_days_sorted[i] = dry_days[i];
    }

    void build(int node, int start, int end) {
        if (start == end) {
            tree[node] = dry_days_sorted[start];
        } else {
            int mid = (start + end) / 2;
            build(2 * node, start, mid);
            build(2 * node + 1, mid + 1, end);
            tree[node] = (rains[dry_days_sorted[2 * node + 1]] < rains[dry_days_sorted[2 * node]] ? dry_days_sorted[2 * node + 1] : dry_days_sorted[2 * node]);
        }
    }

    int query(int node, int start, int end, int l, int r) {
        if (r < start || end < l) {
            return -1;
        }
        if (l <= start && end <= r) {
            return tree[node];
        }
        int mid = (start + end) / 2;
        int p1 = query(2 * node, start, mid, l, r);
        int p2 = query(2 * node + 1, mid + 1, end, l, r);
        if (p1 == -1) return p2;
        if (p2 == -1) return p1;
        return (rains[dry_days_sorted[p2]] < rains[dry_days_sorted[p1]] ? p2 : p1);
    }

    void update(int node, int start, int end, int idx) {
        if (start == end) {
            tree[node] = -1;
        } else {
            int mid = (start + end) / 2;
            if (dry_days_sorted[idx] <= mid) {
                update(2 * node, start, mid, idx);
            } else {
                update(2 * node + 1, mid + 1, end, idx);
            }
            if (tree[2 * node] == -1) {
                tree[node] = tree[2 * node + 1];
            } else if (tree[2 * node + 1] == -1) {
                tree[node] = tree[2 * node];
            } else {
                tree[node] = (rains[dry_days_sorted[tree[2 * node + 1]]] < rains[dry_days_sorted[tree[2 * node]]] ? tree[2 * node + 1] : tree[2 * node]);
            }
        }
    }

    for (int i = 1; i <= 200000; i++) {
        last_rain[i] = -1;
    }

    int dry_days_idx = 0;
    for (int i = 0; i < rainsSize; i++) {
        if (rains[i] > 0) {
            last_rain[rains[i]] = i;
        }
    }

    for (int i = 1; i <= 200000; i++) {
        if (last_rain[i] == -1) continue;
        rains[last_rain[i]] = i;
    }

    for (int i = 0; i < dry_count; i++) {
        rains[dry_days[i]] = 0;
    }

    for (int i = 0; i < rainsSize; i++) {
        if (rains[i] > 0) {
            last_rain[rains[i]] = i;
        }
    }

    for (int i = 0; i < dry_count; i++) {
        dry_days_sorted[i] = dry_days[i];
    }

    for (int i = 0; i < dry_count; i++) {
        rains[dry_days[i]] = 0;
    }

    for (int i = 0; i < dry_count; i++) {
        for (int j = i + 1; j < dry_count; j++) {
            if (dry_days_sorted[i] > dry_days_sorted[j]) {
                int temp = dry_days_sorted[i];
                dry_days_sorted[i] = dry_days_sorted[j];
                dry_days_sorted[j] = temp;
            }
        }
    }

    build(1, 0, dry_count - 1);

    for (int i = 1; i <= 200000; i++) {
        last_rain[i] = -1;
    }

    for (int i = 0; i < rainsSize; i++) {
        if (rains[i] > 0) {
            last_rain[rains[i]] = i;
        }
    }

    for (int i = 0; i < rainsSize; i++) {
        if (ans[i] == -1) {
            int lake = rains[i];
            int next_rain = last_rain[lake];

            int l = 0, r = dry_count - 1, best_idx = -1;
            while (l <= r) {
                int mid = (l + r) / 2;
                if (dry_days_sorted[mid] > i) {
                    best_idx = mid;
                    r = mid - 1;
                } else {
                    l = mid + 1;
                }
            }

            if (best_idx == -1) {
                free(ans);
                free(last_rain);
                free(dry_days);
                free(tree);
                free(dry_days_sorted);
                *returnSize = 0;
                return NULL;
            }

            int best_dry_day = dry_days_sorted[best_idx];
            if (best_dry_day > next_rain) {
                free(ans);
                free(last_rain);
                free(dry_days);
                free(tree);
                free(dry_days_sorted);
                *returnSize = 0;
                return NULL;
            }
            ans[best_dry_day] = lake;
            for(int k =0; k< dry_count; k++){
                if(dry_days_sorted[k] == best_dry_day){
                    update(1, 0, dry_count -1, k);
                    break;
                }
            }
            dry_days_sorted[best_idx] = -1;

        }
    }

    for (int i = 0; i < rainsSize; i++) {
        if (ans[i] == 1) {
            ans[i] = 1;
        }
    }

    free(last_rain);
    free(dry_days);
    free(tree);