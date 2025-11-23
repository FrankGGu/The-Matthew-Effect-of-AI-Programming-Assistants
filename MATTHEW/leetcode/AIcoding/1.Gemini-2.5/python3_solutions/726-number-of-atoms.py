import collections

class Solution:
    def countOfAtoms(self, formula: str) -> str:
        n = len(formula)
        i = 0

        # Stack to store atom counts for different scopes (parentheses)
        # Each element in the stack is a defaultdict(int)
        stack = [collections.defaultdict(int)] 

        while i < n:
            if formula[i] == '(':
                # Push a new map onto the stack for the new scope
                stack.append(collections.defaultdict(int))
                i += 1
            elif formula[i] == ')':
                # Pop the current map, which contains counts for the just-closed scope
                current_map = stack.pop()
                i += 1

                # Parse the multiplier (number) immediately after ')'
                start_num = i
                while i < n and formula[i].isdigit():
                    i += 1

                # If no number is present, the multiplier is 1
                multiplier = int(formula[start_num:i] or 1) 

                # Apply the multiplier to atoms in current_map and merge into the map below it on the stack
                for atom, count in current_map.items():
                    stack[-1][atom] += count * multiplier
            else: # Must be an atom name
                start_atom = i
                i += 1 # The first character of an atom name is always uppercase

                # Read any subsequent lowercase letters for the full atom name
                while i < n and formula[i].islower():
                    i += 1
                atom_name = formula[start_atom:i]

                # Parse the count for the atom
                start_num = i
                while i < n and formula[i].isdigit():
                    i += 1

                # If no number is present, the count is 1
                count = int(formula[start_num:i] or 1) 

                # Add the count to the current scope's map
                stack[-1][atom_name] += count

        # The final counts are in the last map on the stack (the base scope)
        final_counts = stack[0]

        # Sort atoms alphabetically by their names
        sorted_atoms = sorted(final_counts.keys())

        result = []
        for atom in sorted_atoms:
            result.append(atom)
            # Only append the count if it's greater than 1
            if final_counts[atom] > 1:
                result.append(str(final_counts[atom]))

        return "".join(result)