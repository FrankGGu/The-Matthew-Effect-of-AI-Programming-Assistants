class Solution:
    def capitalizeTitle(self, title: str) -> str:
        result = []
        capitalize_next = True

        for char in title:
            if char.isalpha():
                if capitalize_next:
                    result.append(char.upper())
                    capitalize_next = False
                else:
                    result.append(char.lower())
            else:
                result.append(char)
                capitalize_next = True

        return "".join(result)