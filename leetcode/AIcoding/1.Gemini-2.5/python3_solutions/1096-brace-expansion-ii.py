class Solution:
    def braceExpansionII(self, expression: str) -> list[str]:
        self.expression = expression
        self.idx = 0

        def parse_concat_sequence():
            current_concat_set = {""}

            while self.idx < len(self.expression) and self.expression[self.idx] not in [',', '}']:

                term_set = set()

                if self.expression[self.idx].isalpha():
                    term_set = {self.expression[self.idx]}
                    self.idx += 1
                elif self.expression[self.idx] == '{':
                    self.idx += 1
                    term_set = parse_union_sequence()
                    self.idx += 1

                new_concat_set = set()
                for w1 in current_concat_set:
                    for w2 in term_set:
                        new_concat_set.add(w1 + w2)
                current_concat_set = new_concat_set

            return current_concat_set

        def parse_union_sequence():
            current_union_set = set()

            while True:
                current_union_set.update(parse_concat_sequence())

                if self.idx < len(self.expression) and self.expression[self.idx] == ',':
                    self.idx += 1
                else:
                    break

            return current_union_set

        result_set = parse_union_sequence()

        return sorted(list(result_set))