class Solution:
    def longestCommonSubpath(self, n: int, paths: List[List[int]]) -> int:
        def rabin_karp(length):
            base = 10**6 + 3
            mod = 2**63 - 1
            hashes = set()
            current_hash = 0
            base_pow = 1

            for i in range(length):
                current_hash = (current_hash * base + paths[0][i]) % mod
                base_pow = (base_pow * base) % mod

            hashes.add(current_hash)

            for start in range(1, len(paths[0]) - length + 1):
                current_hash = (current_hash * base - paths[0][start - 1] * base_pow + paths[0][start + length - 1]) % mod
                hashes.add(current_hash)

            for path in paths[1:]:
                current_hash = 0
                for i in range(length):
                    current_hash = (current_hash * base + path[i]) % mod

                if current_hash in hashes:
                    return True

                base_pow = 1
                for start in range(1, len(path) - length + 1):
                    current_hash = (current_hash * base - path[start - 1] * base_pow + path[start + length - 1]) % mod
                    if current_hash in hashes:
                        return True
                    base_pow = (base_pow * base) % mod

            return False

        left, right = 1, min(len(path) for path in paths)
        answer = 0

        while left <= right:
            mid = (left + right) // 2
            if rabin_karp(mid):
                answer = mid
                left = mid + 1
            else:
                right = mid - 1

        return answer