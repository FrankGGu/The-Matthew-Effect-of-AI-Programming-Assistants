class Solution:
    def longestCommonSubpath(self, n: int, paths: List[List[int]]) -> int:
        base = 10**5 + 3
        mod = 10**11 + 7
        power = [1] * (max(len(path) for path in paths) + 1)
        for i in range(1, len(power)):
            power[i] = (power[i-1] * base) % mod

        def has_common_subpath(length):
            if length == 0:
                return True
            hash_map = {}
            for i, path in enumerate(paths):
                current_hash = 0
                seen = set()
                for j in range(len(path)):
                    current_hash = (current_hash * base + path[j]) % mod
                    if j >= length:
                        current_hash = (current_hash - path[j - length] * power[length]) % mod
                    if j >= length - 1:
                        if i == 0:
                            seen.add(current_hash)
                        else:
                            if current_hash in hash_map and hash_map[current_hash] == i:
                                hash_map[current_hash] = i + 1
                if i == 0:
                    for h in seen:
                        hash_map[h] = 1
                else:
                    to_remove = [h for h in hash_map if hash_map[h] != i + 1]
                    for h in to_remove:
                        del hash_map[h]
                    if not hash_map:
                        return False
            return bool(hash_map)

        left, right = 0, min(len(path) for path in paths)
        while left < right:
            mid = (left + right + 1) // 2
            if has_common_subpath(mid):
                left = mid
            else:
                right = mid - 1
        return left