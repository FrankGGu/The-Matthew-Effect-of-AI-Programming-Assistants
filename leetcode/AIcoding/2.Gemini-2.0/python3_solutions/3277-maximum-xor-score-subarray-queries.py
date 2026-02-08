class Solution:
    def maximumXorScoreSubarrayQueries(self, nums: List[int], queries: List[List[int]]) -> List[int]:
        n = len(nums)
        m = len(queries)
        indexed_queries = []
        for i in range(m):
            indexed_queries.append((queries[i][0], queries[i][1], i))
        indexed_queries.sort(key=lambda x: x[1])

        nums_with_index = []
        for i in range(n):
            nums_with_index.append((nums[i], i))
        nums_with_index.sort(key=lambda x: x[0])

        trie = {}

        def insert(num):
            curr = trie
            for i in range(31, -1, -1):
                bit = (num >> i) & 1
                if bit not in curr:
                    curr[bit] = {}
                curr = curr[bit]

        def query(num):
            curr = trie
            xor_sum = 0
            for i in range(31, -1, -1):
                bit = (num >> i) & 1
                if 1 - bit in curr:
                    xor_sum += (1 << i)
                    curr = curr[1 - bit]
                else:
                    curr = curr[bit]
            return xor_sum

        results = [0] * m
        num_idx = 0

        for l, r, idx in indexed_queries:
            while num_idx < n and nums_with_index[num_idx][0] <= r:
                insert(nums_with_index[num_idx][0])
                num_idx += 1

            if not trie:
                results[idx] = -1
            else:
                max_xor = 0
                for i in range(l, r + 1):
                    max_xor = max(max_xor, query(i))
                results[idx] = max_xor

        return results