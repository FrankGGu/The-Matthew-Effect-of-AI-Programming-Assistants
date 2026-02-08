int equalSubstring(char* s, char* t, int maxCost) {
    int n = strlen(s);
    int left = 0, cost = 0, max_len = 0;

    for (int right = 0; right < n; right++) {
        cost += abs(s[right] - t[right]);

        while (cost > maxCost) {
            cost -= abs(s[left] - t[left]);
            left++;
        }

        max_len = fmax(max_len, right - left + 1);
    }

    return max_len;
}