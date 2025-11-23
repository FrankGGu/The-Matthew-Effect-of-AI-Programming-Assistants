class Solution:
    def deleteDuplicateFolders(self, root: 'TreeNode') -> 'TreeNode':
        from collections import defaultdict

        def serialize(node):
            if not node:
                return ""
            key = ""
            for child in node.children:
                key += serialize(child) + "|"
            if key:
                key = key[:-1]
            if key in seen:
                seen[key].append(node)
            else:
                seen[key] = [node]
            return key

        seen = defaultdict(list)
        serialize(root)

        def remove_duplicates(node):
            if not node:
                return None
            for child in node.children:
                remove_duplicates(child)
            if len(seen[serialize(node)]) > 1:
                return None
            return node

        return remove_duplicates(root)