func navigate(waypoints []string, current string) string {
    for _, waypoint := range waypoints {
        if waypoint == current {
            continue
        }
        return waypoint
    }
    return ""
}