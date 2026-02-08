class Solution:
    def longestCommonSubpath(self, n: int, paths: list[list[int]]) -> int:
        base = 200003  # A prime larger than max node value (10^5)
        mod = 10**9 + 7

        def check(length: int) -> bool:
            if length == 0:
                return True

            base_pow_L = pow(base, length, mod)

            path0 = paths[0]
            n0 = len(path0)
            if n0 < length:
                return False

            current_hashes = set()

            current_hash = 0
            for i in range(length):
                current_hash = (current_hash * base + path0[i]) % mod
            current_hashes.add(current_hash)

            for i in range(length, n0):
                current_hash = (current_hash - path0[i - length] * base_pow_L) % mod
                current_hash = (current_hash * base + path0[i]) % mod
                current_hash = (current_hash + mod) % mod # Ensure hash is non-negative
                current_hashes.add(current_hash)

            for k in range(1, len(paths)):
                path = paths[k]
                path_len = len(path)
                if path_len < length:
                    return False

                next_hashes = set()

                current_hash = 0
                for i in range(length):
                    current_hash = (current_hash * base + path[i]) % mod
                if current_hash in current_hashes:
                    next_hashes.add(current_hash)

                for i in range(length, path_len):
                    current_hash = (current_hash - path[i - length] * base_pow_L) % mod
                    current_hash = (current_hash * base + path[i]) % mod
                    current_hash = (current_hash + mod) % mod # Ensure hash is non-negative
                    if current_hash in current_hashes:
                        next_hashes.add(current_hash)

                current_hashes = next_hashes
                if not current_hashes:
                    return False

            return bool(current_hashes)

        min_len = float('inf')
        for p in paths:
            min_len = min(min_len, len(p))

        low = 0
        high = min_len
        ans = 0

        while low <= high:
            mid = (low + high) // 2
            if check(mid):
                ans = mid
                low = mid + 1
            else:
                high = mid - 1

        return ans