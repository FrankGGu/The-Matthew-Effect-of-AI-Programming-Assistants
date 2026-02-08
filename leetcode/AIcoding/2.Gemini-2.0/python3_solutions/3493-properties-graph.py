from collections import defaultdict

class Solution:
    def findPropertiesGraph(self, properties: list[list[str]]) -> list[list[str]]:
        adj = defaultdict(set)
        prop_to_group = {}
        group_to_props = defaultdict(set)
        group_id = 0

        def find_group(prop):
            return prop_to_group.get(prop, -1)

        def union_groups(group1, group2):
            if group1 == group2:
                return
            for prop in group_to_props[group2]:
                prop_to_group[prop] = group1
                group_to_props[group1].add(prop)
            del group_to_props[group2]

        for prop1, prop2 in properties:
            group1 = find_group(prop1)
            group2 = find_group(prop2)

            if group1 == -1 and group2 == -1:
                prop_to_group[prop1] = group_id
                prop_to_group[prop2] = group_id
                group_to_props[group_id].add(prop1)
                group_to_props[group_id].add(prop2)
                group_id += 1
            elif group1 == -1:
                prop_to_group[prop1] = group2
                group_to_props[group2].add(prop1)
            elif group2 == -1:
                prop_to_group[prop2] = group1
                group_to_props[group1].add(prop2)
            else:
                union_groups(group1, group2)

        result = []
        for group in group_to_props.values():
            result.append(sorted(list(group)))

        return sorted(result, key=lambda x: x[0])