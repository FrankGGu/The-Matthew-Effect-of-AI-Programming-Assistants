class Solution:
    def countRectangles(self, rectangles: List[List[int]], points: List[List[int]]) -> List[int]:
        rectangles.sort(key=lambda x: x[0])
        ans = []
        for x, y in points:
            count = 0
            l, r = 0, len(rectangles) - 1

            while l <= r:
                mid = (l + r) // 2
                if rectangles[mid][0] >= x:
                    r = mid - 1
                else:
                    l = mid + 1

            for i in range(l, len(rectangles)):
                if rectangles[i][1] >= y:
                    count += 1
            ans.append(count)
        return ans