class Solution:
    def flipAndInvertImage(self, image: List[List[int]]) -> List[List[int]]:
        for row in image:
            left, right = 0, len(row) - 1
            while left <= right:
                row[left], row[right] = row[right], row[left]
                row[left] = 1 - row[left]
                if left != right:
                    row[right] = 1 - row[right]
                left += 1
                right -= 1
        return image