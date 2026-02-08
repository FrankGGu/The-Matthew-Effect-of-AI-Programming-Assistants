int beautifulBouquet(int* flowers, int flowersSize, int cnt) {
    int mod = 1000000007;
    int left = 0;
    int result = 0;
    int freq[100001] = {0};

    for (int right = 0; right < flowersSize; right++) {
        freq[flowers[right]]++;
        while (freq[flowers[right]] > cnt) {
            freq[flowers[left]]--;
            left++;
        }
        result = (result + right - left + 1) % mod;
    }

    return result;
}