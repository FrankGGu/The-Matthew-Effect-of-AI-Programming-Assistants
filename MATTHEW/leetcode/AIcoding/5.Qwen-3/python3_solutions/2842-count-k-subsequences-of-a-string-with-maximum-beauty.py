class Solution:
    def countMaximumBeauty(self, s: str, k: int) -> int:
        from collections import Counter
        import math

        def get_max_beauty(s, k):
            cnt = Counter(s)
            max_beauty = 0
            for c in cnt:
                if cnt[c] >= k:
                    max_beauty += k * (ord(c) - ord('a') + 1)
            return max_beauty

        def count_subsequences(s, k, target_beauty):
            from collections import defaultdict
            dp = defaultdict(int)
            dp[0] = 1
            for ch in s:
                new_dp = dp.copy()
                for key in dp:
                    if key + (ord(ch) - ord('a') + 1) <= target_beauty:
                        new_dp[key + (ord(ch) - ord('a') + 1)] += dp[key]
                dp = new_dp
            return dp[target_beauty]

        max_beauty = get_max_beauty(s, k)
        return count_subsequences(s, k, max_beauty)