class Solution:
    def countKdivSubarr(self, A: List[int], K: int) -> int:
        count = 0
        n = len(A)
        mod_count = {0: 1}
        curr_sum = 0

        for num in A:
            curr_sum += num
            mod = curr_sum % K
            if mod < 0:
                mod += K
            if mod in mod_count:
                count += mod_count[mod]
                mod_count[mod] += 1
            else:
                mod_count[mod] = 1

        return count