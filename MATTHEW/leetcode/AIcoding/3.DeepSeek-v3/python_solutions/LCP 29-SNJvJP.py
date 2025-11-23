class Solution:
    def orchestraLayout(self, num: int, xPos: int, yPos: int) -> int:
        layer = min(xPos, yPos, num - 1 - xPos, num - 1 - yPos)
        total = 4 * layer * (num - layer)
        n = num - 2 * layer
        if xPos == layer:
            total += yPos - layer + 1
        elif yPos == num - 1 - layer:
            total += n - 1 + xPos - layer + 1
        elif xPos == num - 1 - layer:
            total += 2 * (n - 1) + (num - 1 - layer - yPos) + 1
        else:
            total += 3 * (n - 1) + (num - 1 - layer - xPos) + 1
        return (total - 1) % 9 + 1