class Solution:
    def fullJustify(self, words: list[str], maxWidth: int) -> list[str]:
        result = []
        n = len(words)
        i = 0

        while i < n:
            current_line_words = []
            current_line_total_len = -1 

            j = i
            while j < n:
                word = words[j]

                potential_len = 0
                if current_line_total_len == -1:
                    potential_len = len(word)
                else:
                    potential_len = current_line_total_len + 1 + len(word)

                if potential_len <= maxWidth:
                    current_line_words.append(word)
                    current_line_total_len = potential_len
                    j += 1
                else:
                    break

            is_last_line = (j == n)
            num_words_in_line = len(current_line_words)
            total_word_length = sum(len(w) for w in current_line_words)

            line_str_parts = []

            if is_last_line or num_words_in_line == 1:
                line_str = ' '.join(current_line_words)
                line_str += ' ' * (maxWidth - len(line_str))
                result.append(line_str)
            else:
                total_spaces_to_distribute = maxWidth - total_word_length
                num_gaps = num_words_in_line - 1 

                base_spaces_per_gap = total_spaces_to_distribute // num_gaps
                extra_spaces_count = total_spaces_to_distribute % num_gaps

                for k in range(num_words_in_line):
                    line_str_parts.append(current_line_words[k])
                    if k < num_gaps: 
                        spaces_for_this_gap = base_spaces_per_gap
                        if extra_spaces_count > 0:
                            spaces_for_this_gap += 1
                            extra_spaces_count -= 1
                        line_str_parts.append(' ' * spaces_for_this_gap)

                result.append("".join(line_str_parts))

            i = j 

        return result