func canReach(s string, minJump int, maxJump int) bool {
    n := len(s)
    if s[0] == '1' || s[n-1] == '1' {
        return false
    }

    farthest := 0
    reachable := 0

    for i := 0; i < n; i++ {
        if i > farthest {
            return false
        }
        if s[i] == '0' {
            if i >= minJump {
                reachable++
            }
            if i >= maxJump {
                reachable--
            }
        }
        if reachable > 0 {
            farthest = i + maxJump
        }
    }

    return false
}