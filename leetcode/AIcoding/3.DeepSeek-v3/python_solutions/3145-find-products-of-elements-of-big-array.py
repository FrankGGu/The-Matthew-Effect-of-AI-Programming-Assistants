class Solution:
    def findProductsOfElements(self, queries: List[List[int]]) -> List[int]:
        def count_ones_up_to(x):
            res = 0
            bit = 1
            while bit <= x:
                quotient = x // (bit << 1)
                remainder = x % (bit << 1)
                res += quotient * bit
                res += max(0, remainder - bit + 1)
                bit <<= 1
            return res

        def find_kth_element(k):
            low = 0
            high = 1 << 60
            answer = 0
            while low <= high:
                mid = (low + high) // 2
                cnt = count_ones_up_to(mid)
                if cnt < k:
                    low = mid + 1
                else:
                    answer = mid
                    high = mid - 1
            return answer

        def sum_of_ones_up_to(x):
            res = 0
            bit = 1
            while bit <= x:
                quotient = x // (bit << 1)
                remainder = x % (bit << 1)
                res += quotient * bit * bit
                res += max(0, remainder - bit + 1) * bit
                bit <<= 1
            return res

        def sum_bits_in_range(l, r):
            return sum_of_ones_up_to(r) - sum_of_ones_up_to(l - 1)

        result = []
        for l, r, mod in queries:
            total = sum_bits_in_range(l + 1, r + 1)
            if mod == 1:
                res = 0
            else:
                res = pow(2, total, mod)
            result.append(res)
        return result