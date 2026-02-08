class Solution:
    def twoEditWords(self, queries: List[str], dictionary: List[str]) -> List[str]:
        result = []
        for query_word in queries:
            for dict_word in dictionary:
                diff_count = 0
                for i in range(len(query_word)):
                    if query_word[i] != dict_word[i]:
                        diff_count += 1

                if diff_count <= 2:
                    result.append(query_word)
                    break
        return result