class Solution:
    def spellchecker(self, wordlist: List[str], queries: List[str]) -> List[str]:
        def devowel(word):
            return ''.join('*' if c.lower() in 'aeiou' else c.lower() for c in word)

        words_perfect = set(wordlist)
        words_cap = {}
        words_vow = {}

        for word in wordlist:
            word_low = word.lower()
            words_cap.setdefault(word_low, word)
            words_vow.setdefault(devowel(word_low), word)

        def solve(query):
            if query in words_perfect:
                return query

            query_low = query.lower()
            if query_low in words_cap:
                return words_cap[query_low]

            query_vow = devowel(query_low)
            if query_vow in words_vow:
                return words_vow[query_vow]

            return ""

        return [solve(query) for query in queries]