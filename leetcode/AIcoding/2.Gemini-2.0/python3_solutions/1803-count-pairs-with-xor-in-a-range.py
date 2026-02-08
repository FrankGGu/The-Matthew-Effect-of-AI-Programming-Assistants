class Solution:
    def countPairs(self, nums: List[int], low: int, high: int) -> int:
        def count_less_equal(nums, k):
            trie = {}
            count = 0
            for num in nums:
                node = trie
                curr = 0
                for i in range(14, -1, -1):
                    bit_num = (num >> i) & 1
                    bit_k = (k >> i) & 1
                    if bit_k == 0:
                        if 1 not in node:
                            break
                        node = node[1]
                    else:
                        if 0 in node:
                            curr += node[0]
                        if 0 not in node:
                            break
                        node = node[0]
                else:
                    count += 1
                node = trie
                for i in range(14, -1, -1):
                    bit = (num >> i) & 1
                    if bit not in node:
                        node[bit] = {}
                    if 0 not in node[bit]:
                        node[bit][0] = 0
                    node[bit][0] += 1
                    node = node[bit]
            return count

        return count_less_equal(nums, high) - count_less_equal(nums, low - 1)