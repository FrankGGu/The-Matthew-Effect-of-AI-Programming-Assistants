from collections import defaultdict, deque
from typing import List

class Solution:
    def checkDFSStringsArePalindromes(self, n: int, edges: List[List[int]], s: str) -> bool:
        if n == 0:
            return False

        adj = defaultdict(list)
        for u, v in edges:
            adj[u].append(v)
            adj[v].append(u)

        # Function to check if a mask represents a string whose characters
        # can be rearranged into a palindrome.
        # This is true if at most one character has an odd count.
        # In bitmask terms, the mask is 0 (all even counts) or a power of 2 (exactly one odd count).
        def is_palindrome_possible(mask: int) -> bool:
            return (mask == 0) or ((mask & (mask - 1)) == 0)

        # visited stores (node, mask) pairs to avoid redundant computations and infinite loops.
        # A mask represents the parity of character counts from the start of a path
        # to the current node.
        visited = set()

        # We use BFS for state-space exploration, which is equivalent to DFS
        # in terms of finding reachable states. The problem title "DFS Strings"
        # implies the method of generating strings (paths), not necessarily
        # the traversal algorithm itself. BFS is often preferred for reachability
        # on graphs with cycles to avoid recursion depth limits.
        q = deque()

        # To avoid the trivial case where any single-character path is considered a palindrome
        # (which would always return True for n > 0), we initialize the search with paths
        # of length at least 2. These are paths formed by traversing an edge.
        # For each edge (u, v), we consider paths starting with s[u]s[v] and s[v]s[u].
        for u, v in edges:
            # Path s[u]s[v]:
            # The mask for this path is the XOR of masks for s[u] and s[v].
            mask_uv = (1 << (ord(s[u]) - ord('a'))) ^ (1 << (ord(s[v]) - ord('a')))

            if is_palindrome_possible(mask_uv):
                return True # Found a path of length 2 that is a palindrome

            # Add state (v, mask_uv) to the queue to continue path from v.
            # mask_uv represents the character counts from the start of this path (u) to v.
            if (v, mask_uv) not in visited:
                q.append((v, mask_uv))
                visited.add((v, mask_uv))

            # Path s[v]s[u]:
            mask_vu = (1 << (ord(s[v]) - ord('a'))) ^ (1 << (ord(s[u]) - ord('a')))

            if is_palindrome_possible(mask_vu):
                return True # Found a path of length 2 that is a palindrome

            # Add state (u, mask_vu) to the queue to continue path from u.
            # mask_vu represents the character counts from the start of this path (v) to u.
            if (u, mask_vu) not in visited:
                q.append((u, mask_vu))
                visited.add((u, mask_vu))

        # BFS traversal to explore longer paths
        while q:
            u, current_mask = q.popleft()

            for v in adj[u]:
                # Extend the current path by adding character s[v].
                # The new mask is the current_mask XORed with the mask for s[v].
                new_mask = current_mask ^ (1 << (ord(s[v]) - ord('a')))

                # If the extended path forms a palindrome, we found one.
                if is_palindrome_possible(new_mask):
                    return True

                # If this (node, mask) state has not been visited, add it to the queue.
                if (v, new_mask) not in visited:
                    visited.add((v, new_mask))
                    q.append((v, new_mask))

        # If no such path is found after exploring all reachable states, return False.
        return False