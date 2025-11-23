typedef long long ll;

ll countKConstraintSubstrings(char* s, int k) {
    int n = strlen(s);
    ll res = 0;
    int left = 0;
    int count0 = 0, count1 = 0;

    for (int right = 0; right < n; right++) {
        if (s[right] == '0') count0++;
        else count1++;

        while (count0 > k && count1 > k) {
            if (s[left] == '0') count0--;
            else count1--;
            left++;
        }

        res += (right - left + 1);
    }

    return res;
}