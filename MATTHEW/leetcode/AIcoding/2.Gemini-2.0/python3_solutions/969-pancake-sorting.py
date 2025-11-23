class Solution:
    def flip(self, arr, k):
        i, j = 0, k - 1
        while i < j:
            arr[i], arr[j] = arr[j], arr[i]
            i += 1
            j -= 1

    def pancakeSort(self, arr):
        n = len(arr)
        ans = []
        for i in range(n, 0, -1):
            max_index = arr.index(i)
            if max_index != i - 1:
                if max_index != 0:
                    self.flip(arr, max_index + 1)
                    ans.append(max_index + 1)
                self.flip(arr, i)
                ans.append(i)
        return ans