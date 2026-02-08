class Solution:
    def findSolution(self, customfunction: 'CustomFunction', z: int) -> List[List[int]]:
        result = []
        x, y = 1, 1000

        while x <= 1000 and y >= 1:
            f_xy = customfunction.f(x, y)
            if f_xy == z:
                result.append([x, y])
                x += 1
            elif f_xy < z:
                x += 1
            else:
                y -= 1

        return result