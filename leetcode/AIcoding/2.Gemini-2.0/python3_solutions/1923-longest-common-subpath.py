def longestCommonSubpath(n: int, paths: list[list[int]]) -> int:
    def check(length):
        if length == 0:
            return True

        first_path = paths[0]
        first_path_hashes = set()
        for i in range(len(first_path) - length + 1):
            subpath = first_path[i:i+length]
            hash_val = 0
            for j in range(length):
                hash_val = (hash_val * base + subpath[j]) % mod
            first_path_hashes.add(hash_val)

        for path in paths[1:]:
            current_path_hashes = set()
            for i in range(len(path) - length + 1):
                subpath = path[i:i+length]
                hash_val = 0
                for j in range(length):
                    hash_val = (hash_val * base + subpath[j]) % mod
                current_path_hashes.add(hash_val)

            first_path_hashes = first_path_hashes.intersection(current_path_hashes)
            if not first_path_hashes:
                return False
        return True

    mod = 10**9 + 7
    base = 101

    min_len = min(len(path) for path in paths)

    left, right = 0, min_len
    ans = 0

    while left <= right:
        mid = (left + right) // 2
        if check(mid):
            ans = mid
            left = mid + 1
        else:
            right = mid - 1

    return ans