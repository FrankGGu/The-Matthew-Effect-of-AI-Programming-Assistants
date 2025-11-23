class Solution:
    def smallestEquivalentString(self, s1: str, s2: str, baseStr: str) -> str:
        parent = list(range(26)) # Each character 'a' through 'z' is initially its own parent

        def find(i):
            if parent[i] == i:
                return i
            parent[i] = find(parent[i]) # Path compression
            return parent[i]

        def union(i, j):
            root_i = find(i)
            root_j = find(j)

            if root_i != root_j:
                # The representative of the merged set should be the lexicographically smaller character
                if root_i < root_j:
                    parent[root_j] = root_i
                else:
                    parent[root_i] = root_j

        # Process s1 and s2 to build equivalence classes
        for char1, char2 in zip(s1, s2):
            union(ord(char1) - ord('a'), ord(char2) - ord('a'))

        # Build the result string
        result = []
        for char_code in baseStr:
            # Find the representative (smallest character) for the current character's equivalence class
            root_char_code = find(ord(char_code) - ord('a'))
            result.append(chr(ord('a') + root_char_code))

        return "".join(result)