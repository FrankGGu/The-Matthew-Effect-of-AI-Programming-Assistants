class Solution:
    def minOperations(self, target: List[int], arr: List[int]) -> int:
        pos = {num: i for i, num in enumerate(target)}
        stack = []
        for num in arr:
            if num not in pos:
                continue
            idx = pos[num]
            if not stack or idx > stack[-1]:
                stack.append(idx)
            else:
                left, right = 0, len(stack) - 1
                while left <= right:
                    mid = (left + right) // 2
                    if stack[mid] < idx:
                        left = mid + 1
                    else:
                        right = mid - 1
                stack[left] = idx
        return len(target) - len(stack)