MOD = 10**9 + 7

def countKSubsequencesWithMaxBeauty(s: str, k: int) -> int:
    freq = [0] * 26
    for char in s:
        freq[ord(char) - ord('a')] += 1

    freq.sort(reverse=True)

    min_freq = freq[k-1]

    count_min_freq = freq.count(min_freq)

    count_selected = sum(1 for i in range(k) if freq[i] == min_freq)

    def nCr(n, r):
        if r > n:
            return 0

        num = 1
        den = 1
        for i in range(r):
            num = (num * (n - i)) % MOD
            den = (den * (i + 1)) % MOD

        return (num * pow(den, MOD - 2, MOD)) % MOD

    ans = nCr(count_min_freq, count_selected)

    for i in range(k):
        if freq[i] > min_freq:
            ans = (ans * pow(freq[i], 1, MOD)) % MOD

    ans = (ans * pow(min_freq, count_selected, MOD)) % MOD

    return ans