from collections import defaultdict
import re

def countOfAtoms(formula: str) -> str:
    def parse_formula(formula):
        stack = []
        count = defaultdict(int)
        i = 0
        n = len(formula)

        while i < n:
            if formula[i].isupper():  # Start of a new element
                j = i + 1
                while j < n and formula[j].islower():  # Get the full element name
                    j += 1
                element = formula[i:j]
                count[element] += 1
                i = j
            elif formula[i].isdigit():  # Count after an element
                j = i
                while j < n and formula[j].isdigit():
                    j += 1
                num = int(formula[i:j])
                last_element = stack.pop() if stack else None
                count[last_element] += num - 1
                i = j
            elif formula[i] == '(':  # Start of a group
                stack.append(formula[i])
                i += 1
            elif formula[i] == ')':  # End of a group
                j = i + 1
                while j < n and formula[j].isdigit():
                    j += 1
                multiplier = int(formula[i + 1:j]) if i + 1 < j else 1
                while stack and stack[-1] != '(':
                    last_element = stack.pop()
                    count[last_element] += multiplier
                stack.pop()  # Remove the '('
                i = j
            else:
                i += 1

        for elem in count:
            stack.append((elem, count[elem]))

        return stack

    atom_counts = parse_formula(formula)
    atom_counts.sort()

    result = []
    for atom, count in atom_counts:
        result.append(atom + (str(count) if count > 1 else ''))

    return ''.join(result)