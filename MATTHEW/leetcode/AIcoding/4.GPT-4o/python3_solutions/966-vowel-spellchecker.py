class Solution:
    def spellchecker(self, wordlist: List[str], queries: List[str]) -> List[str]:
        def normalize(word):
            return ''.join(c if c not in 'aeiou' else '*' for c in word)

        word_set = set(wordlist)
        normalized_map = {}
        for word in wordlist:
            norm = normalize(word)
            if norm not in normalized_map:
                normalized_map[norm] = word

        results = []
        for query in queries:
            if query in word_set:
                results.append(query)
            else:
                norm_query = normalize(query)
                if norm_query in normalized_map:
                    results.append(normalized_map[norm_query])
                else:
                    results.append("")

        return results