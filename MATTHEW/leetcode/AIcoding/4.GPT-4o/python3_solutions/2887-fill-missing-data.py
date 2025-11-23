class Solution:
    def fillMissingData(self, data: List[int]) -> List[int]:
        n = len(data)
        for i in range(n):
            if data[i] == -1:
                left = right = i
                while left > 0 and data[left - 1] == -1:
                    left -= 1
                while right < n - 1 and data[right + 1] == -1:
                    right += 1
                if left > 0:
                    left_value = data[left - 1]
                else:
                    left_value = 0
                if right < n - 1:
                    right_value = data[right + 1]
                else:
                    right_value = 0
                fill_value = (left_value + right_value) // 2
                for j in range(i, right + 1):
                    data[j] = fill_value
        return data