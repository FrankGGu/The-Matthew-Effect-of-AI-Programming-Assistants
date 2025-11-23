class Solution:
    def minimumInteger(self, num: str, k: int) -> str:
        num_list = list(num)
        n = len(num_list)

        for i in range(n):
            if k <= 0:
                break
            min_index = i
            for j in range(i + 1, min(n, i + k + 1)):
                if num_list[j] < num_list[min_index]:
                    min_index = j

            for j in range(min_index, i, -1):
                num_list[j], num_list[j - 1] = num_list[j - 1], num_list[j]
                k -= 1
                if k == 0:
                    break

        return ''.join(num_list)