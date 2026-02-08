long long combinations[51][51];

void precompute_combinations() {
    for (int i = 0; i <= 50; ++i) {
        combinations[i][0] = 1;
        for (int j = 1; j <= i; ++j) {
            combinations[i][j] = combinations[i-1][j-1] + combinations[i-1][j];
        }
    }
}

int numberOfSets(int n, int k, int maxDistance) {
    precompute_combinations();

    long long total_sets = 0;

    if (k == n) {
        return 1;
    }

    for (int L = 0; L < n; ++L) {
        for (int R = L; R < n; ++R) {
            if (R - L > maxDistance) {
                break;
            }

            int must_close_count = L + (n - 1 - R);

            if (must_close_count > k) {
                continue;
            }

            int branches_in_middle = R - L - 1;
            int needed_optional_closures = k - must_close_count;

            if (branches_in_middle < 0) {
                if (needed_optional_closures == 0) {
                    total_sets += 1;
                }
                continue;
            }

            if (needed_optional_closures < 0 || needed_optional_closures > branches_in_middle) {
                continue;
            }

            total_sets += combinations[branches_in_middle][needed_optional_closures];
        }
    }

    return (int)total_sets;
}