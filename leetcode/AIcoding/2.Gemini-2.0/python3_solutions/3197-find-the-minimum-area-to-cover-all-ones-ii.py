class Solution:
    def minArea(self, image: List[List[str]], x: int, y: int) -> int:
        rows = len(image)
        cols = len(image[0])

        def search_left(low, high):
            while low < high:
                mid = (low + high) // 2
                found = False
                for i in range(rows):
                    for j in range(mid, y + 1):
                        if image[i][j] == '1':
                            found = True
                            break
                    if found:
                        break
                if found:
                    high = mid
                else:
                    low = mid + 1
            return low

        def search_right(low, high):
            while low < high:
                mid = (low + high + 1) // 2
                found = False
                for i in range(rows):
                    for j in range(y, mid + 1):
                        if image[i][j] == '1':
                            found = True
                            break
                    if found:
                        break
                if found:
                    low = mid
                else:
                    high = mid - 1
            return low

        def search_top(low, high):
            while low < high:
                mid = (low + high) // 2
                found = False
                for i in range(mid, x + 1):
                    for j in range(cols):
                        if image[i][j] == '1':
                            found = True
                            break
                    if found:
                        break
                if found:
                    high = mid
                else:
                    low = mid + 1
            return low

        def search_bottom(low, high):
            while low < high:
                mid = (low + high + 1) // 2
                found = False
                for i in range(x, mid + 1):
                    for j in range(cols):
                        if image[i][j] == '1':
                            found = True
                            break
                    if found:
                        break
                if found:
                    low = mid
                else:
                    high = mid - 1
            return low

        left = search_left(0, y)
        right = search_right(y, cols - 1)
        top = search_top(0, x)
        bottom = search_bottom(x, rows - 1)

        return (right - left + 1) * (bottom - top + 1)