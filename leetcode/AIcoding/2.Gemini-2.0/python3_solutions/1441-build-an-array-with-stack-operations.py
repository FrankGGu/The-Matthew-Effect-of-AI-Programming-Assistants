class Solution:
    def buildArray(self, target: List[int], n: int) -> List[str]:
        stack = []
        result = []
        index = 0
        for i in range(1, n + 1):
            if index == len(target):
                break

            result.append("Push")
            stack.append(i)

            if stack[-1] == target[index]:
                index += 1
            else:
                result.append("Pop")
                stack.pop()

        return result