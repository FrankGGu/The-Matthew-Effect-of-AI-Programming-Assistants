class Solution:
    def pancakeSort(self, arr: list[int]) -> list[int]:
        n = len(arr)
        result = []

        def flip(k):
            # Flips the first k elements of arr
            # arr[:k] = arr[:k][::-1]
            left = 0
            right = k - 1
            while left < right:
                arr[left], arr[right] = arr[right], arr[left]
                left += 1
                right -= 1

        for target_val in range(n, 0, -1):
            idx = -1
            for i in range(target_val):
                if arr[i] == target_val:
                    idx = i
                    break

            if idx == target_val - 1:
                continue

            if idx != 0:
                flip(idx + 1)
                result.append(idx + 1)

            flip(target_val)
            result.append(target_val)

        return result