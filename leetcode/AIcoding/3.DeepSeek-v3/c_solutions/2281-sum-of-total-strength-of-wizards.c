typedef long long ll;

int totalStrength(int* strength, int strengthSize) {
    int n = strengthSize;
    int mod = 1000000007;

    ll* prefix = (ll*)malloc((n + 1) * sizeof(ll));
    ll* prefix_prefix = (ll*)malloc((n + 2) * sizeof(ll));
    int* left = (int*)malloc(n * sizeof(int));
    int* right = (int*)malloc(n * sizeof(int));
    int* stack = (int*)malloc(n * sizeof(int));

    prefix[0] = 0;
    for (int i = 0; i < n; i++) {
        prefix[i + 1] = (prefix[i] + strength[i]) % mod;
    }

    prefix_prefix[0] = 0;
    for (int i = 0; i <= n; i++) {
        prefix_prefix[i + 1] = (prefix_prefix[i] + prefix[i]) % mod;
    }

    int top = -1;
    for (int i = 0; i < n; i++) {
        while (top >= 0 && strength[stack[top]] >= strength[i]) {
            top--;
        }
        left[i] = (top == -1) ? -1 : stack[top];
        stack[++top] = i;
    }

    top = -1;
    for (int i = n - 1; i >= 0; i--) {
        while (top >= 0 && strength[stack[top]] > strength[i]) {
            top--;
        }
        right[i] = (top == -1) ? n : stack[top];
        stack[++top] = i;
    }

    ll res = 0;
    for (int i = 0; i < n; i++) {
        int l = left[i] + 1;
        int r = right[i] - 1;

        ll left_sum = (prefix_prefix[i + 1] - prefix_prefix[l] + mod) % mod;
        ll right_sum = (prefix_prefix[r + 2] - prefix_prefix[i + 1] + mod) % mod;

        ll cnt_left = (ll)(i - l + 1);
        ll cnt_right = (ll)(r - i + 1);

        ll total = (right_sum * cnt_left % mod - left_sum * cnt_right % mod + mod) % mod;
        res = (res + total * strength[i] % mod) % mod;
    }

    free(prefix);
    free(prefix_prefix);
    free(left);
    free(right);
    free(stack);

    return res;
}