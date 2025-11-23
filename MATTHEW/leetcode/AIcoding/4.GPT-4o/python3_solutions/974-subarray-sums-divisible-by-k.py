class Solution:
    def subarraysDivByK(self, A: List[int], K: int) -> int:
        count = 0
        prefix_sum = 0
        modulo_count = {0: 1}

        for num in A:
            prefix_sum += num
            mod = prefix_sum % K
            if mod < 0:
                mod += K

            if mod in modulo_count:
                count += modulo_count[mod]
                modulo_count[mod] += 1
            else:
                modulo_count[mod] = 1

        return count