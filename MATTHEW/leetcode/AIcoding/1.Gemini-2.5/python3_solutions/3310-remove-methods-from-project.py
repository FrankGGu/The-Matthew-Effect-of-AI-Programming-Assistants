class Solution:
    def removeMethods(self, all_methods: list[str], methods_to_remove: list[str]) -> list[str]:
        remove_set = set(methods_to_remove)
        remaining_methods = []
        for method in all_methods:
            if method not in remove_set:
                remaining_methods.append(method)
        return remaining_methods