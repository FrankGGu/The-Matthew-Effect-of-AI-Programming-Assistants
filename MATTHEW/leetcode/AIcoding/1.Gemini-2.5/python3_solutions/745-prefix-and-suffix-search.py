from typing import List

class WordFilter:

    def __init__(self, words: List[str]):
        self.memo = {}
        for i, word in enumerate(words):
            n = len(word)
            # Generate all possible suffixes
            # word[j:] gives suffixes starting from index j
            for j in range(n + 1):
                suffix = word[j:]
                # Generate all possible prefixes
                # word[:k] gives prefixes ending before index k
                for k in range(n + 1):
                    prefix = word[:k]
                    # Store the combined string "suffix#prefix" with its index
                    # If multiple words result in the same combined string,
                    # the one with the largest index (processed last) will be stored.
                    self.memo[suffix + '#' + prefix] = i

    def f(self, pref: str, suff: str) -> int:
        # Construct the query string in the same format as stored keys
        query_key = suff + '#' + pref
        # Retrieve the index from the memoization dictionary, default to -1 if not found
        return self.memo.get(query_key, -1)