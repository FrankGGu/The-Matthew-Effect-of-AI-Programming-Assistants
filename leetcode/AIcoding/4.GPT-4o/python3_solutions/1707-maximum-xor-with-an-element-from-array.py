class Solution:
    def maximizeXor(self, nums: List[int], queries: List[List[int]]) -> List[int]:
        nums.sort()
        results = []
        max_num = max(nums)
        trie = {}

        def insert(num):
            node = trie
            for i in range(31, -1, -1):
                bit = (num >> i) & 1
                if bit not in node:
                    node[bit] = {}
                node = node[bit]

        def query(num):
            node = trie
            max_xor = 0
            for i in range(31, -1, -1):
                bit = (num >> i) & 1
                opposite_bit = 1 - bit
                if opposite_bit in node:
                    max_xor |= (1 << i)
                    node = node[opposite_bit]
                else:
                    node = node.get(bit, {})
            return max_xor

        for num in nums:
            insert(num)

        queries = sorted(enumerate(queries), key=lambda x: x[1][0])
        current_max = -1

        for index, (x, m) in queries:
            while current_max + 1 < len(nums) and nums[current_max + 1] <= m:
                current_max += 1
            if current_max == -1:
                results.append(0)
            else:
                results.append(query(x))

        return [results[i] for i in sorted(range(len(results)), key=lambda x: queries[x][0])]