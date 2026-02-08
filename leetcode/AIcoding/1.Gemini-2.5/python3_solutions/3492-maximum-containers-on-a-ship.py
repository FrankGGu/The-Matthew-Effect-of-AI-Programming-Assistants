class Solution:
    def maxUnits(self, containerTypes: list[list[int]], shipCapacity: int) -> int:
        containerTypes.sort(key=lambda x: x[1], reverse=True)

        total_units = 0
        for num_containers, units_per_container in containerTypes:
            if shipCapacity == 0:
                break

            containers_to_take = min(num_containers, shipCapacity)
            total_units += containers_to_take * units_per_container
            shipCapacity -= containers_to_take

        return total_units