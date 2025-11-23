class Solution:
    def countPairs(self, nums: List[int], low: int, high: int) -> int:
        def count(nums, x):
            res = 0
            max_bit = x.bit_length() if x != 0 else 0
            trie = {}
            for num in nums:
                node = trie
                for i in range(max_bit - 1, -1, -1):
                    bit = (num >> i) & 1
                    if bit not in node:
                        node[bit] = {}
                    node = node[bit]
                node['#'] = node.get('#', 0) + 1

            for num in nums:
                node = trie
                for i in range(max_bit - 1, -1, -1):
                    bit_num = (num >> i) & 1
                    bit_x = (x >> i) & 1
                    if bit_x == 1:
                        if (1 - bit_num) in node:
                            res += node[1 - bit_num].get('#', 0)
                        if bit_num in node:
                            node = node[bit_num]
                        else:
                            break
                    else:
                        if bit_num in node:
                            node = node[bit_num]
                        else:
                            break
                    if i == 0 and '#' in node:
                        res += node['#']
            return res // 2

        return count(nums, high + 1) - count(nums, low)