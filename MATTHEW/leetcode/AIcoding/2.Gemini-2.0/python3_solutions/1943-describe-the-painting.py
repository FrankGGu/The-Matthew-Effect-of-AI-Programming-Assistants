class Solution:
    def splitPainting(self, segments: List[List[int]]) -> List[List[int]]:
        points = set()
        for start, end, _ in segments:
            points.add(start)
            points.add(end)

        points = sorted(list(points))

        prefix_sum = defaultdict(int)
        for start, end, color in segments:
            prefix_sum[start] += color
            prefix_sum[end] -= color

        result = []
        for i in range(len(points) - 1):
            start = points[i]
            end = points[i+1]

            color = 0
            for j in range(len(segments)):
                s,e,c = segments[j]
                if start >= s and start < e:
                  color += c

            if color > 0:
                result.append([start, end, color])

        return result