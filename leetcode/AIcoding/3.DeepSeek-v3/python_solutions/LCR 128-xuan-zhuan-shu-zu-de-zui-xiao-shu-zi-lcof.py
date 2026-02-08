class Solution:
    def stockManagement(self, stock: List[int]) -> int:
        left, right = 0, len(stock) - 1
        while left < right:
            mid = (left + right) // 2
            if stock[mid] < stock[right]:
                right = mid
            elif stock[mid] > stock[right]:
                left = mid + 1
            else:
                right -= 1
        return stock[left]