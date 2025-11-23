class Solution:
    def spellchecker(self, wordlist: List[str], queries: List[str]) -> List[str]:
        words_perfect = set(wordlist)
        words_cap = {}
        words_vowel = {}

        def devowel(word):
            return "".join('*' if c in 'aeiouAEIOU' else c for c in word)

        for word in wordlist:
            lower_word = word.lower()
            if lower_word not in words_cap:
                words_cap[lower_word] = word
            devoweled_word = devowel(lower_word)
            if devoweled_word not in words_vowel:
                words_vowel[devoweled_word] = word

        result = []
        for query in queries:
            if query in words_perfect:
                result.append(query)
            else:
                lower_query = query.lower()
                if lower_query in words_cap:
                    result.append(words_cap[lower_query])
                else:
                    devoweled_query = devowel(lower_query)
                    if devoweled_query in words_vowel:
                        result.append(words_vowel[devoweled_query])
                    else:
                        result.append("")
        return result