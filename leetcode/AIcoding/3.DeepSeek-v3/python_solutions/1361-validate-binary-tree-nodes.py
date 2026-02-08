class Solution:
    def validateBinaryTreeNodes(self, n: int, leftChild: List[int], rightChild: List[int]) -> bool:
        parent = {}
        for i in range(n):
            left = leftChild[i]
            right = rightChild[i]
            if left != -1:
                if left in parent:
                    return False
                parent[left] = i
            if right != -1:
                if right in parent:
                    return False
                parent[right] = i

        root = -1
        for i in range(n):
            if i not in parent:
                if root != -1:
                    return False
                root = i

        if root == -1:
            return False

        visited = set()
        stack = [root]
        while stack:
            node = stack.pop()
            if node in visited:
                return False
            visited.add(node)
            if leftChild[node] != -1:
                stack.append(leftChild[node])
            if rightChild[node] != -1:
                stack.append(rightChild[node])

        return len(visited) == n