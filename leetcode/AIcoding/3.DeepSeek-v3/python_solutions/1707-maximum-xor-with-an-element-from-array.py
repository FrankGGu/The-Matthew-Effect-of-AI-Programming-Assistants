class Solution:
    def maximizeXor(self, nums: List[int], queries: List[List[int]]) -> List[int]:
        nums.sort()
        queries = sorted([(x, m, i) for i, (x, m) in enumerate(queries)], key=lambda q: q[1])
        trie = {}
        res = [-1] * len(queries)
        ptr = 0
        for x, m, idx in queries:
            while ptr < len(nums) and nums[ptr] <= m:
                node = trie
                for i in range(30, -1, -1):
                    bit = (nums[ptr] >> i) & 1
                    if bit not in node:
                        node[bit] = {}
                    node = node[bit]
                ptr += 1
            if not trie:
                continue
            node = trie
            current_xor = 0
            for i in range(30, -1, -1):
                bit = (x >> i) & 1
                toggled_bit = 1 - bit
                if toggled_bit in node:
                    current_xor += (1 << i)
                    node = node[toggled_bit]
                else:
                    node = node.get(bit, {})
            res[idx] = current_xor
        return res