class Solution:
    def expressiveWords(self, s: str, words: list[str]) -> int:

        def get_char_counts(text: str) -> list[tuple[str, int]]:
            if not text:
                return []

            groups = []
            i = 0
            while i < len(text):
                char = text[i]
                count = 0
                j = i
                while j < len(text) and text[j] == char:
                    count += 1
                    j += 1
                groups.append((char, count))
                i = j
            return groups

        s_groups = get_char_counts(s)
        expressive_count = 0

        for word in words:
            w_groups = get_char_counts(word)

            if len(s_groups) != len(w_groups):
                continue

            is_expressive = True
            for i in range(len(s_groups)):
                s_char, s_count = s_groups[i]
                w_char, w_count = w_groups[i]

                if s_char != w_char:
                    is_expressive = False
                    break

                if s_count < w_count:
                    is_expressive = False
                    break

                if s_count > w_count and s_count < 3:
                    is_expressive = False
                    break

            if is_expressive:
                expressive_count += 1

        return expressive_count