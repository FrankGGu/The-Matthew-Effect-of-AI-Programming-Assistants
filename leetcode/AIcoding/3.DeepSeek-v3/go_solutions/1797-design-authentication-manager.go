type AuthenticationManager struct {
    timeToLive int
    tokens     map[string]int
}

func Constructor(timeToLive int) AuthenticationManager {
    return AuthenticationManager{
        timeToLive: timeToLive,
        tokens:     make(map[string]int),
    }
}

func (this *AuthenticationManager) Generate(tokenId string, currentTime int) {
    this.tokens[tokenId] = currentTime + this.timeToLive
}

func (this *AuthenticationManager) Renew(tokenId string, currentTime int) {
    if expiry, exists := this.tokens[tokenId]; exists && expiry > currentTime {
        this.tokens[tokenId] = currentTime + this.timeToLive
    }
}

func (this *AuthenticationManager) CountUnexpiredTokens(currentTime int) int {
    count := 0
    for _, expiry := range this.tokens {
        if expiry > currentTime {
            count++
        }
    }
    return count
}

/**
 * Your AuthenticationManager object will be instantiated and called as such:
 * obj := Constructor(timeToLive);
 * obj.Generate(tokenId,currentTime);
 * obj.Renew(tokenId,currentTime);
 * param_3 := obj.CountUnexpiredTokens(currentTime);
 */